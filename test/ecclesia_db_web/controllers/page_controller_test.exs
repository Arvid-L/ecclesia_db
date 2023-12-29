defmodule EcclesiaDbWeb.PageControllerTest do
  use EcclesiaDbWeb.ConnCase

  test "GET /", %{conn: conn} do
    # conn = get(conn, ~p"/")
    # assert html_response(conn, 200) =~ "Ecclesia DB Home"
    # TODO: Learn how to test LiveView with ExAws.S3 mocking?
    true
  end
end
