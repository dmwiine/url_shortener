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

  def new(conn, _params) do
    changeset = Links.change_link(%Link{})
    render(conn, "new.html", changeset: changeset)
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

  # def get_and_redirect(conn, %{"id" => id}) do
  #   url = id
  #     |> Links.get_link!()
  #     |> Map.get(:url)
  #   redirect(conn, external: url)
  # end

  def show(conn, %{"slug" => slug}) do
    link = Links.get_link(slug)
    redirect(conn, external: link.url)
  end

  # def edit(conn, %{"id" => id}) do
  #   link = Links.get_link!(id)
  #   changeset = Links.change_link(link)
  #   render(conn, "edit.html", link: link, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "link" => link_params}) do
  #   link = Links.get_link!(id)

  #   case Links.update_link(link, link_params) do
  #     {:ok, link} ->
  #       conn
  #       |> put_flash(:info, "Link updated successfully.")
  #       |> redirect(to: Routes.link_path(conn, :show, link))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", link: link, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   link = Links.get_link!(id)
  #   {:ok, _link} = Links.delete_link(link)

  #   conn
  #   |> put_flash(:info, "Link deleted successfully.")
  #   |> redirect(to: Routes.link_path(conn, :index))
  # end
end
