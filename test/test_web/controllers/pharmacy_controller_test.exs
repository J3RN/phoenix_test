defmodule TestWeb.PharmacyControllerTest do
  use TestWeb.ConnCase

  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "new pharmacy" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pharmacy_path(conn, :new))
      assert html_response(conn, 200) =~ "Register Pharmacy"
    end
  end

  describe "create pharmacy" do
    test "redirects to show with successful create", %{conn: conn} do
      password = "asdfasdf"

      create_attrs =
        params_for(:pharmacy)
        |> Map.put(:password, password)
        |> Map.put(:password_confirmation, password)

      conn = post(conn, Routes.pharmacy_path(conn, :create), pharmacy: create_attrs)

      assert redirected_to(conn) == Routes.order_path(conn, :index)

      conn = get(conn, Routes.pharmacy_path(conn, :show, conn.assigns.current_pharmacy.id))
      assert html_response(conn, 200) =~ "Show Pharmacy"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pharmacy_path(conn, :create), pharmacy: @invalid_attrs)
      assert html_response(conn, 200) =~ "Register Pharmacy"
    end

    test "renders errors when password confirmation does not match", %{conn: conn} do
      pharmacy_params =
        params_for(:pharmacy)
        |> Map.put(:password, "asdfasdf")
        |> Map.put(:password_confirmation, "foobar1")

      conn = post(conn, Routes.pharmacy_path(conn, :create), pharmacy: pharmacy_params)
      assert html_response(conn, 200) =~ "Register Pharmacy"
    end

    test "renders errors when password confirmation is missing", %{conn: conn} do
      pharmacy_params = Map.put(params_for(:pharmacy), :password, "adsfadsf")
      conn = post(conn, Routes.pharmacy_path(conn, :create), pharmacy: pharmacy_params)
      assert html_response(conn, 200) =~ "Register Pharmacy"
    end
  end

  describe "edit pharmacy" do
    setup [:create_pharmacy]

    test "renders form for editing chosen pharmacy", %{conn: conn, pharmacy: pharmacy} do
      conn = get(conn, Routes.pharmacy_path(conn, :edit, pharmacy))
      assert html_response(conn, 200) =~ "Edit Pharmacy"
    end
  end

  describe "update pharmacy" do
    setup [:create_pharmacy]

    test "redirects when data is valid", %{conn: conn, pharmacy: pharmacy} do
      conn = put(conn, Routes.pharmacy_path(conn, :update, pharmacy), pharmacy: @update_attrs)
      assert redirected_to(conn) == Routes.pharmacy_path(conn, :show, pharmacy)

      conn = get(conn, Routes.pharmacy_path(conn, :show, pharmacy))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, pharmacy: pharmacy} do
      conn = put(conn, Routes.pharmacy_path(conn, :update, pharmacy), pharmacy: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pharmacy"
    end
  end

  describe "delete pharmacy" do
    setup [:create_pharmacy]

    test "deletes chosen pharmacy", %{conn: conn, pharmacy: pharmacy} do
      conn = delete(conn, Routes.pharmacy_path(conn, :delete, pharmacy))
      assert redirected_to(conn) == Routes.page_path(conn, :index)

      assert_error_sent(404, fn ->
        get(conn, Routes.pharmacy_path(conn, :show, pharmacy))
      end)
    end
  end

  defp create_pharmacy(%{conn: conn}) do
    pharmacy = insert(:pharmacy)
    conn = put_session(conn, "pharmacy_id", pharmacy.id)

    %{conn: conn, pharmacy: pharmacy}
  end
end
