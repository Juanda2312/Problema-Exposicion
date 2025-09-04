defmodule Util do
    @moduledoc """
    Módulo con funciones a reutilizar
    - autor: Juan David Tapiero
    - fecha: 19/08/2025
    - licencia: GNU GPL V3
    """

    @doc """
    Imprime el mensaje en terminal.

    ## Parámetros
      - mensaje: Mensaje a mostrar en la terminal.
    """
    def mostrar_mensaje(mensaje) do
      mensaje
      |>IO.puts()
    end

    @doc """
    Muestra un mensaje de error en la salida estándar de errores.
    ## Parámetros
      - mensaje: Mensaje de error a mostrar.
    """
    def mostrar_error(mensaje) do
      IO.puts(:standard_error, mensaje)
    end

    @doc """
    Imprime un mensaje mediante la terminal y recibe el contenido escrito en esta.

    ## Parámetros
      - mensaje: Mensaje a mostrar en la terminal.
    """
    def ingresar(mensaje, :texto) do
    mensaje
    |>IO.gets()
    |>String.trim()
    end

    @doc """
    Solicita al usuario que ingrese un número entero mediante la terminal.
    Si el usuario ingresa un valor no válido, muestra un mensaje de error y vuelve a solicitar la entrada.

    ## Parámetros

      - mensaje: Mensaje a mostrar al usuario.
    """
    def ingresar(mensaje, :entero) do
      ingresar(mensaje, &String.to_integer/1, :entero)
    end

    @doc """
    Solicita al usuario que ingrese un número real mediante la terminal.
    Si el usuario ingresa un valor no válido, muestra un mensaje de error y vuelve a solicitar la entrada.

    ## Parámetros

      - mensaje: Mensaje a mostrar al usuario.
    """
    def ingresar(mensaje,:real) do
      ingresar(mensaje,&String.to_float/1, :real)
    end

    defp ingresar(mensaje, parser, tipo_dato) do
      try do
        mensaje
        |> ingresar(:texto)
        |> parser.()
      rescue
        ArgumentError ->
          "Error, se espera que ingrese un número #{tipo_dato}\n"
          |> mostrar_error()
          mensaje
          |> ingresar(parser, tipo_dato)
      end
    end
  end
