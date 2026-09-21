defmodule MyMusic do

  def iniciar do
    canciones = [
      %{
        id: 1,
        titulo: "Spring Day",
        artista: "BTS",
        genero: "K-pop",
        duracion: 274,
        favorita: true
      },
      %{
        id: 2,
        titulo: "Break Stuff",
        artista: "Limp Bizkit",
        genero: "Nu Metal",
        duracion: 246,
        favorita: false
      },
      %{
        id: 3,
        titulo: "Chop Suey!",
        artista: "System of a Down",
        genero: "Nu Metal",
        duracion: 330,
        favorita: false
      }
    ]

    playlists = [
      %{
        id: 1,
        nombre: "Para Entrenar",
        descripcion: "Canciones para escuchar mientras hago ejercicio",
        canciones: [2, 3]
      },
      %{
        id: 2,
        nombre: "Favoritas",
        descripcion: "Mis canciones favoritas",
        canciones: [1]
      }
    ]

    menu(canciones, playlists)
  end

end
