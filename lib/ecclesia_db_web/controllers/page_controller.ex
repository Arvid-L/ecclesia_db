defmodule EcclesiaDbWeb.PageController do
  use EcclesiaDbWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def image(conn, %{"id" => id}) do
    {:ok, %{body: image_content}} =
      ExAws.S3.get_object("ecclesia-db", "example/#{id}")
      |> ExAws.request(region: "eu-central-1")

    conn
    |> put_resp_content_type("image/png")
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=\"file.png\""
    )
    |> send_resp(200, image_content)
  end
end
