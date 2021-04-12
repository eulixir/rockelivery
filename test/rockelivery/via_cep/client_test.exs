defmodule Rockelivery.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn

  alias Rockelivery.Error
  alias Rockelivery.ViaCep.Client

  import Rockelivery.Factory

  describe "get_cep_info/1" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "when there is a valid cep, returns the cep info", %{bypass: bypass} do
      cep = "01001000"

      url = endpoint_url(bypass.port)

      body = ~s({
        "cep": "01001-000",
        "logradouro": "Praça da Sé",
        "complemento": "lado ímpar",
        "bairro": "Sé",
        "localidade": "São Paulo",
        "uf": "SP",
        "ibge": "3550308",
        "gia": "1004",
        "ddd": "11",
        "siafi": "7107"
      })

      Bypass.expect(bypass, "GET", "/#{cep}/json/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      expected_response = {:ok, build(:cep_info)}

      response = Client.get_cep_info(url, cep)

      assert response == expected_response
    end

    test "when the cep is invalid, returns an error", %{bypass: bypass} do
      cep = "123"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "/#{cep}/json/", fn conn ->
        Conn.resp(conn, 400, "")
      end)

      expected_response = {:error, %Error{result: "Invalid CEP!", status: :bad_request}}

      response = Client.get_cep_info(url, cep)

      assert response == expected_response
    end

    test "when the cep is not found, returns an error", %{bypass: bypass} do
      cep = "00000000"

      body = ~s({"erro": true})

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "/#{cep}/json/", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      expected_response = {:error, %Error{result: "CEP not found!", status: :not_found}}

      response = Client.get_cep_info(url, cep)

      assert response == expected_response
    end

    test "when there is a generic error, returns the error", %{bypass: bypass} do
      cep = "01001000"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      response = Client.get_cep_info(url, cep)

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
