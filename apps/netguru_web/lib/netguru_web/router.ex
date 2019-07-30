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

  pipeline :authenticated do
    plug NetguruWeb.Guardian.Pipeline
  end

  scope "/", NetguruWeb do
    pipe_through [:browser, :authenticated] # Use the default browser stack

    resources "/articles", ArticleController, only: [:delete, :create]
    resources "/authors", AuthorController, only: [:show]
  end

  scope "/", NetguruWeb do
    pipe_through :browser

    resources "/authors", AuthorController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", NetguruWeb do
  #   pipe_through :api
  # end
end
