defmodule TestWeb.NoAuth do
  def init(opts), do: opts
  def call(conn, _opts) do
    Plug.Conn.assign(conn, :current_pharmacy, %Test.Pharmacies.Pharmacy{id: -1})
  end
  def authenticate(conn), do: conn
end
