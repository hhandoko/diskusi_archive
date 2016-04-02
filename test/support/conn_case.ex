#
# File     : conn_case.ex
# License  :
#   The MIT License (MIT)
#
#   Copyright (c) 2016 Herdy Handoko
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#   THE SOFTWARE.
#
defmodule Diskusi.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      # Ecto / DAL support
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]

      # Reverse routing support
      import Diskusi.Router.Helpers

      # Guardian login helper functions
      #import Diskusi.Guardian.Helpers

      alias Diskusi.Repo
      alias Diskusi.User

      # The default endpoint for testing
      @endpoint Diskusi.Endpoint

      # FIXME: Duplicate function in `integration_case.ex`, unable to extract to a separate module as it's throwing `RuntimeError`
      # Guardian login helper functions
      # ~~~~
      # We need a way to get into the connection to login a user
      # We need to use the `bypass_through` to fire the plugs in the router
      # and get the session fetched.
      #
      # Example:
      #   conn =
      #     conn
      #     |> guardian_login(user)
      #     |> get(home_path(conn, :index))
      #
      def guardian_login(%User{} = user), do: guardian_login(conn(), user, :token, [])
      def guardian_login(%User{} = user, token), do: guardian_login(conn(), user, token, [])
      def guardian_login(%User{} = user, token, opts), do: guardian_login(conn(), user, token, opts)

      def guardian_login(%Plug.Conn{} = conn, user), do: guardian_login(conn, user, :token, [])
      def guardian_login(%Plug.Conn{} = conn, user, token), do: guardian_login(conn, user, token, [])
      def guardian_login(%Plug.Conn{} = conn, user, token, opts) do
        conn
          |> bypass_through(Diskusi.Router, [:browser])
          |> get("/")
          |> Guardian.Plug.sign_in(user, token, opts)
          |> send_resp(200, "Flush the session")
          |> recycle()
      end
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Diskusi.Repo, [])
    end

    {:ok, conn: Phoenix.ConnTest.conn()}
  end
end
