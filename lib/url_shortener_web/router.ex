defmodule UrlShortenerWeb.Router do
  use UrlShortenerWeb, :router

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

  scope "/", UrlShortenerWeb do
    pipe_through :browser

    get "/", LinkController, :index
    get "/:slug", LinkController, :show
    post "/shorten", LinkController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", UrlShortenerWeb do
  #   pipe_through :api
  # end
end
