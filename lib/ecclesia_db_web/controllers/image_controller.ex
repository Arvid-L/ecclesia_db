defmodule EcclesiaDbWeb.ImageController do
  use EcclesiaDbWeb, :controller

  def get(conn, %{"id" => id}) do
    {:ok, %{body: image_content}} =
      ExAws.S3.get_object(System.get_env("S3_BUCKET_NAME"), "images/#{id}")
      |> ExAws.request(region: "eu-central-1")

    conn
    |> put_resp_content_type("image/png")
    |> put_resp_header(
      "content-disposition",
      "attachment; filename=\"#{id}.png\""
    )
    |> send_resp(200, image_content)
  end
end
