defmodule TestWeb.Router do
  use TestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TestWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/pharmacies", PharmacyController, except: [:index]
    resources "/locations", LocationController
    resources "/prescriptions", PrescriptionController
    resources "/patients", PatientController
    resources "/orders", OrderController
  end
end
