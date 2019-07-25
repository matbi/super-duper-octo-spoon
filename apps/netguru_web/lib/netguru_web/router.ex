defmodule NetguruWeb.Router do
  use NetguruWeb, :router

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

  scope "/", NetguruWeb do
    pipe_through :browser # Use the default browser stack

    resources "/articles", ArticleController, only: [:delete, :create]
    resources "/authors", AuthorController, only: [:show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", NetguruWeb do
  #   pipe_through :api
  # end
end
