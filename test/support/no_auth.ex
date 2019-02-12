defmodule TestWeb.NoAuth do
  import Plug.Conn

  def init(opts), do: opts
  def call(conn, _opts) do
    pharmacy = %Test.Pharmacies.Pharmacy{
      id: get_session(conn, "pharmacy_id") || -1
    }

    Plug.Conn.assign(conn, :current_pharmacy, pharmacy)
  end
  def authenticate(conn), do: conn
end
