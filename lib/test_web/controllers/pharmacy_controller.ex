defmodule TestWeb.PharmacyController do
  use TestWeb, :controller

  alias Test.Pharmacies
  alias Test.Pharmacies.Pharmacy

  plug :verify_ownership when action in [:show, :edit, :update, :delete]

  def new(conn, _params) do
    changeset = Pharmacies.change_pharmacy(%Pharmacy{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pharmacy" => pharmacy_params}) do
    case Pharmacies.create_pharmacy(pharmacy_params) do
      {:ok, pharmacy} ->
        conn
        |> TestWeb.Auth.login(pharmacy)
        |> put_flash(:info, "Pharmacy created successfully.")
        |> redirect(to: Routes.order_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pharmacy = Pharmacies.get_pharmacy!(id)
    render(conn, "show.html", pharmacy: pharmacy)
  end

  def edit(conn, %{"id" => id}) do
    pharmacy = Pharmacies.get_pharmacy!(id)
    changeset = Pharmacies.change_pharmacy(pharmacy)
    render(conn, "edit.html", pharmacy: pharmacy, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pharmacy" => pharmacy_params}) do
    pharmacy = Pharmacies.get_pharmacy!(id)

    case Pharmacies.update_pharmacy(pharmacy, pharmacy_params) do
      {:ok, pharmacy} ->
        conn
        |> put_flash(:info, "Pharmacy updated successfully.")
        |> redirect(to: Routes.pharmacy_path(conn, :show, pharmacy))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pharmacy: pharmacy, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pharmacy = Pharmacies.get_pharmacy!(id)
    {:ok, _pharmacy} = Pharmacies.delete_pharmacy(pharmacy)

    conn
    |> put_flash(:info, "Pharmacy deleted successfully.")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def verify_ownership(conn, _opts) do
    if String.to_integer(conn.params["id"]) == conn.assigns.current_pharmacy.id do
      conn
    else
      conn
      |> put_flash(:error, "That's not yours!")
      |> redirect(to: Routes.pharmacy_path(conn, :show, conn.assigns.current_pharmacy))
      |> halt()
    end
  end
end
