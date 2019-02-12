defmodule TestWeb.LocationController do
  use TestWeb, :controller

  alias Test.Pharmacies
  alias Test.Pharmacies.Location

  def index(conn, _params) do
    locations = Pharmacies.list_locations_for_pharmacy(conn.assigns.current_pharmacy)
    render(conn, "index.html", locations: locations)
  end

  def new(conn, _params) do
    changeset = Pharmacies.change_location(%Location{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"location" => location_params}) do
    location_params
    |> Map.put("pharmacy_id", conn.assigns.current_pharmacy.id)
    |> Pharmacies.create_location()
    |> case do
      {:ok, location} ->
        conn
        |> put_flash(:info, "Location created successfully.")
        |> redirect(to: Routes.location_path(conn, :show, location))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    location = Pharmacies.get_location_for_pharmacy!(id, conn.assigns.current_pharmacy)
    render(conn, "show.html", location: location)
  end

  def edit(conn, %{"id" => id}) do
    location = Pharmacies.get_location_for_pharmacy!(id, conn.assigns.current_pharmacy)
    changeset = Pharmacies.change_location(location)
    render(conn, "edit.html", location: location, changeset: changeset)
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Pharmacies.get_location_for_pharmacy!(id, conn.assigns.current_pharmacy)

    case Pharmacies.update_location(location, location_params) do
      {:ok, location} ->
        conn
        |> put_flash(:info, "Location updated successfully.")
        |> redirect(to: Routes.location_path(conn, :show, location))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", location: location, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Pharmacies.get_location_for_pharmacy!(id, conn.assigns.current_pharmacy)
    {:ok, _location} = Pharmacies.delete_location(location)

    conn
    |> put_flash(:info, "Location deleted successfully.")
    |> redirect(to: Routes.location_path(conn, :index))
  end
end
