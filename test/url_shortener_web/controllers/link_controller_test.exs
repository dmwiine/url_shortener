defmodule UrlShortenerWeb.LinkControllerTest do
  use UrlShortenerWeb.ConnCase

  alias UrlShortener.Links

  @create_attrs %{url: "www.google.com"}
  @invalid_attrs %{url: nil}

  def fixture(:link) do
    {:ok, link} = Links.create_link(@create_attrs)
    link
  end

  describe "index" do
    test "lists all links", %{conn: conn} do
      conn = get(conn, Routes.link_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Recent Links"
    end
  end

  describe "create link" do
    test "redirects to  when data is valid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @create_attrs)
      assert redirected_to(conn) == Routes.link_path(conn, :index)

      conn = get(conn, Routes.link_path(conn, :index))
      assert html_response(conn, 200) =~ "www.google.com"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.link_path(conn, :create), link: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops, something went wrong! Please check the errors below"
    end
  end
end
