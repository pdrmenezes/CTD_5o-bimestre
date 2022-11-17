/*
1. configurar Service = criar arquivo rickMorty.js dentro da pasta services
2. utilizar createApi do rtk (@reduxjs/toolkit/query/react) que gerará hooks automaticamente a partir dos endpoints que definirmos na api
3. utilizar fetchBaseQuery também do mesmo import do createApi 
*/

/* CÓDIGO COMENTADO */

// importação de createApi e fetchBaseQuery do Redux Toolkit

import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'


// definição de um service onde criaremos os endpoints que serão exportados em forma de hook para serem utilizados na aplicação 
// recebe 3 objetos (reducerPath, baseQuery, endpoints)
export const rickMortyApi = createApi({
  reducerPath: 'rickMortyApi,

  // baseQuery é utilizado para informar a baseUrl da Api
  baseQuery: fetchBaseQuery({ baseUrl: 'https://rickandmortyapi.com/api/' }),

  // endpoints criará hooks a partir dos endpoints que definirmos, por padrão recebe o parâmetro "builder" que será usado para criar/construir cada endpoint
  endpoints: (builder) => ({

    // getRickMortyCharacterById é o primeiro endpoint que criaremos, usando o método builder
    getRickMortyCharacterById: builder.query({
      query: (id) => `character/${id}`
    })
  })
})

// por fim, exportaremos os hooks gerados pela nossa api, baseados nos endpoints criados
export const { getRickMortyCharacterById } = rickMortyApi


/* CÓDIGO SEM COMENTÁRIOS */

import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

export const rickMortyApi = createApi({
  reducerPath: 'rickMortyApi,
  baseQuery: fetchBaseQuery({ baseUrl: 'https://rickandmortyapi.com/api/' }),
  endpoints: (builder) => ({
    getRickMortyCharacterById: builder.query({
      query: (id) => `character/${id}`
    })
  })
})

export const { getRickMortyCharacterById } = rickMortyApi

/*
4. após configurar o Service, configuramos a Store - a função createApi importada no Service cria automaticamente um Reducer e um Middleware para integrarmos facilmente o Service à Store
*/

/* CÓDIGO COMENTADO */

// importação das funções que utilizaremos para configurar a store e habilitar funcionalidades extras como refetchOnFocus e refetchOnReconnect
import { configureStore } from '@reduxjs/toolkit'
import { setupListeners } from '@reduxjs/toolkit/query'
// importação do Service criado anteriormente
import { rickMortyApi } from './services/rickandmortyapi'

export const store = configureStore({
  reducer: {
    // adição do Reducer gerado automaticamente pela createApi do Service
    [rickMortyApi.reducerPath]: rickMortyApi.reducer
  },
  // adição do Middleware criado automaticamente pela createApi como Middleware padrão da nossa Store
  middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(rickMortyApi.middleware)
})

// setupListeners usado para permitir que usemos refetchOnFocus e refetchOnReconnect na store
setupListeners(store.dispatch)


/* CÓDIGO SEM COMENTÁRIOS */
import { configureStore } from '@reduxjs/toolkit'
import { setupListeners } from '@reduxjs/toolkit/query'
import { rickMortyApi } from './services/rickandmortyapi'

export const store = configureStore({
  reducer: {
    [rickMortyApi.reducerPath]: rickMortyApi.reducer
  },
  middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(rickMortyApi.middleware)
})

setupListeners(store.dispatch)

/*
5. com todas as configurações feitas, podemos usar os hooks gerados pelo Service
6. Nesse caso temos um componente para renderizar os detalhes do Character, que receberemos como objeto por meio das props do componente e passaremos o props.id para o hook buscar os detalhes da API
7. importar hook criado automaticamente no Service (useGetRickMortyCharacterById) a partir do endpoint (GetRickMortyCharacterById)
8. utilização como qualquer outro hook gerado: definimos uma constante onde desestruturaremos o retornos do hook (data, error e isLoading)
9. passar o parâmetro definido para a função getRickMortyCharacterById, no caso, o id, recebido como props pelo componente
*/

/* CÓDIGO COMENTADO */
// importação do hook gerado automaticamente a partir do endpoint criado
import { useGetRickMortyCharacterById } from './services/rickMorty.js'

// componente react normal que recebe o objeto character completo para ser desestruturado
export default function characterDetails(character) {

  // declaração do hook e desestruturação dos retornos dele para usar as informações recebidas da API dentro do componente
  const { data, error, isLoading } = useGetRickMortyCharacterById(character.id)

  // renderização normal do componente
  return (
    <>
      <h1>{character.name}</h1>
      <h2>{character.age}</h2>
      <p>{character.description}</p>
    </>
  )
}

/* CÓDIGO SEM COMENTÁRIO */

import { useGetRickMortyCharacterById } from './services/rickMorty.js'

export default function characterDetails(character) {
  const { data, error, isLoading } = useGetRickMortyCharacterById(character.id)

  return (
    <>
      <h1>{character.name}</h1>
      <h2>{character.age}</h2>
      <p>{character.description}</p>
    </>
  )
}