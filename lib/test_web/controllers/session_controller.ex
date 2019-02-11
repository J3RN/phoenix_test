defmodule TestWeb.SessionController do
  use TestWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{name: name, password: password}}) do
    conn
  end

  def delete(conn, _params), do: conn
end
