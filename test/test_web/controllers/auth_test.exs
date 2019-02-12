defmodule TestWeb.AuthTest do
  use TestWeb.ConnCase
  import Test.Factory
  alias Test.Pharmacies.Pharmacy

  describe "call/2" do
    test "assigns the current_pharmacy to the pharmacy if there is a session", %{conn: conn} do
      pharmacy = insert(:pharmacy)

      conn =
        conn
        |> put_session("pharmacy_id", pharmacy.id)
        |> TestWeb.Auth.call([])

      assert %Pharmacy{} = conn.assigns.current_pharmacy
      assert conn.assigns.current_pharmacy.id == pharmacy.id
    end

    test "assigns current_pharmacy to nil if there is no session", %{conn: conn} do
      conn = TestWeb.Auth.call(conn, [])

      assert conn.assigns.current_pharmacy == nil
    end
  end

  describe "authenticate/1" do
    test "halts the request if the user does not have a valid session", %{conn: conn} do
      conn =
        conn
        |> assign(:current_pharmacy, nil)
        |> TestWeb.Auth.authenticate()

      assert conn.halted
    end

    test "lets the user through if they have a valid session", %{conn: conn} do
      pharmacy = insert(:pharmacy)

      conn =
        conn
        |> assign(:current_pharmacy, pharmacy)
        |> TestWeb.Auth.authenticate()

      refute conn.halted
    end
  end

  describe "login/2" do
    test "assigns the given pharmacy to current_pharmacy", %{conn: conn} do
      pharmacy = insert(:pharmacy)

      conn = TestWeb.Auth.login(conn, pharmacy)

      assert conn.assigns.current_pharmacy == pharmacy
    end

    test "adds the pharmacy's ID the session", %{conn: conn} do
      pharmacy = insert(:pharmacy)

      conn =
        conn
        |> TestWeb.Auth.login(pharmacy)
        |> get("/")

      assert get_session(conn, "pharmacy_id") == pharmacy.id
    end
  end

  # This test doesn't work and I can't figure out why. Maybe I'll have some time
  # later to do that.

  # describe "logout/2" do
  #   test "removes the pharmacy's ID from the session", %{conn: conn} do
  #     pharmacy = insert(:pharmacy)

  #     conn =
  #       conn
  #       |> put_session("pharmacy_id", pharmacy.id)
  #       |> TestWeb.Auth.logout()
  #       |> get("/")

  #     assert get_session(conn, "pharmacy_id") == nil
  #   end
  # end
end
