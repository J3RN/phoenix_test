defmodule TestWeb.PageControllerTest do
  use TestWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to J3RN's Test Phoenix Application!"
  end
end
