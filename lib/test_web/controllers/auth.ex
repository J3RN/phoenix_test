defmodule TestWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias TestWeb.Router.Helpers, as: Routes
  alias Test.Pharmacies

  def call(conn, _opts) do
    pharmacy_id = get_session(conn, "pharmacy_id")
    pharmacy = pharmacy_id && Pharmacies.get_pharmacy!(pharmacy_id)
    assign(conn, :current_pharmacy, pharmacy)
  end

  def authenticate(conn, _opts) do
    if conn.assigns.current_pharmacy do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to view that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def login(conn, pharmacy) do
    conn
    |> assign(:current_pharmacy, pharmacy)
    |> put_session("pharmacy_id", pharmacy.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
