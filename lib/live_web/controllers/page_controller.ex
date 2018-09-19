defmodule LiveWeb.PageController do
  use LiveWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
