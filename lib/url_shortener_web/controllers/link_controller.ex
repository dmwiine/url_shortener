defmodule UrlShortenerWeb.LinkController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Links
  alias UrlShortener.Links.Link
  # alias UrlShortenerWeb.ErrorView

  def index(conn, _params) do
    changeset = Links.change_link(%Link{})
    links = Links.list_links()
    render(conn, "index.html", links: links, changeset: changeset)
  end

  def create(conn, %{"link" => link_params}) do
    case Links.create_link(link_params) do
      {:ok, _params} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: "/")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", links: Links.list_links(), changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    link = Links.get_link(slug)
    redirect(conn, external: link.url)
  end
end
