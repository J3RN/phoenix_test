defmodule TestWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      import Test.Factory
      alias TestWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint TestWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Test.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Test.Repo, {:shared, self()})
    end

    conn =
      Phoenix.ConnTest.build_conn()
      |> Plug.Test.init_test_session(%{})
      |> Phoenix.ConnTest.fetch_flash()

    {:ok, conn: conn}
  end
end
