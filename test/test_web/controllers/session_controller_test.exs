defmodule TestWeb.SessionControllerTest do
  use TestWeb.ConnCase

  describe "new" do
    test "renders login form", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      assert html_response(conn, 200) =~ "Login"
    end
  end
end
