defmodule EcclesiaDbWeb.HomeLive do
  use EcclesiaDbWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> assign(:most_recent_image, get_most_recent_image())
     |> allow_upload(:avatar, accept: ~w(.png .jpg .jpeg .webp), max_entries: 1)}
  end

  defp get_most_recent_image() do
    {:ok, %{body: %{contents: list_of_objects}}} =
      ExAws.S3.list_objects(System.get_env("S3_BUCKET_NAME"))
      |> ExAws.request(region: "eu-central-1")

    list_of_objects
    |> Enum.reject(fn object -> String.ends_with?(object.key, "/") end)
    |> Enum.reject(fn object -> String.starts_with?(object.key, "uploads/") end)
    |> Enum.sort_by(fn object -> object.last_modified end, :desc)
    |> Enum.at(0)
    |> Map.get(:key)
    |> String.split("/")
    |> Enum.at(-1)
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :avatar, ref)}
  end

  @impl Phoenix.LiveView
  def handle_event("save", _params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :avatar, fn %{path: path}, entry ->
        custom_filename = "#{entry.uuid}#{Path.extname(entry.client_name)}"
        # Upload to S3
        {:ok, image_binary} = File.read(path)

        ExAws.S3.put_object(
          System.get_env("S3_BUCKET_NAME"),
          "images/#{custom_filename}",
          image_binary
        )
        |> ExAws.request!(region: "eu-central-1")

        # Save locally, not used at the time
        # dest = Path.join([:code.priv_dir(:ecclesia_db), "static", "uploads", custom_filename])
        # File.cp!(path, dest)

        {:ok, ~p"/images/#{custom_filename}"}
      end)

    socket = update(socket, :uploaded_files, &(&1 ++ uploaded_files))

    socket =
      assign(socket,
        most_recent_image: uploaded_files |> Enum.at(0) |> String.split("/") |> Enum.at(-1)
      )

    {:noreply, socket}
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
