defmodule Diskusi.PageControllerTest do
  use Diskusi.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<div id=\"elm-main\" class=\"container\"></div>"
  end
end
