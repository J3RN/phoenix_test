defmodule TestWeb.SessionController do
  use TestWeb, :controller
  alias Test.Pharmacies

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"name" => name, "password" => password}}) do
    case Pharmacies.authenticate_pharmacy(name, password) do
      {:ok, pharmacy} ->
        conn
        |> TestWeb.Auth.login(pharmacy)
        |> redirect(to: Routes.order_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> TestWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
