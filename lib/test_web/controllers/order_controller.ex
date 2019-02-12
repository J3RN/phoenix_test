defmodule TestWeb.OrderController do
  use TestWeb, :controller

  alias Test.Orders
  alias Test.Orders.Order
  alias Test.Pharmacies

  def index(conn, _params) do
    orders = Orders.list_orders_for_pharmacy(conn.assigns.current_pharmacy)
    render(conn, "index.html", orders: orders)
  end

  def new(conn, _params) do
    changeset = Orders.change_order(%Order{})

    conn
    |> assign_options()
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"order" => order_params}) do
    case Orders.create_order(order_params) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order created successfully.")
        |> redirect(to: Routes.order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign_options()
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order_for_pharmacy!(id, conn.assigns.current_pharmacy)
    render(conn, "show.html", order: order)
  end

  def edit(conn, %{"id" => id}) do
    order = Orders.get_order_for_pharmacy!(id, conn.assigns.current_pharmacy)
    changeset = Orders.change_order(order)

    conn
    |> assign_options()
    |> render("edit.html", order: order, changeset: changeset)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Orders.get_order_for_pharmacy!(id, conn.assigns.current_pharmacy)

    case Orders.update_order(order, order_params) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Order updated successfully.")
        |> redirect(to: Routes.order_path(conn, :show, order))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> assign_options()
        |> render("edit.html", order: order, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Orders.get_order_for_pharmacy!(id, conn.assigns.current_pharmacy)
    {:ok, _order} = Orders.delete_order(order)

    conn
    |> put_flash(:info, "Order deleted successfully.")
    |> redirect(to: Routes.order_path(conn, :index))
  end

  defp assign_options(conn) do
    conn
    |> assign(:locations, Pharmacies.list_locations_for_pharmacy(conn.assigns.current_pharmacy))
    |> assign(:patients, Orders.list_patients())
    |> assign(:prescriptions, Orders.list_prescriptions())
  end
end
