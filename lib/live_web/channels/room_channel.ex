defmodule LiveWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _params, socket) do
    count = Live.Counter.get_count()
    resp = Phoenix.View.render_to_string(LiveWeb.PageView, "counter.html", %{count: count})
    {:ok, %{body: resp}, socket}
  end

  def handle_in("inc", _params, socket) do
    for _x <- 1..10_000_000 do
      Live.Counter.inc()
      broadcast_update(socket)
    end

    {:noreply, socket}
  end

  def handle_in("dec", _params, socket) do
    Live.Counter.dec()
    broadcast_update(socket)
    {:noreply, socket}
  end

  def broadcast_update(socket) do
    count = Live.Counter.get_count()
    resp = Phoenix.View.render_to_string(LiveWeb.PageView, "counter.html", %{count: count})
    broadcast!(socket, "get_data", %{body: resp})
  end
end
