Store = require '../store.coffee'

# Stores components in an object
class MemoryStore extends Store
  # Constructor
  constructor: ->
    @db = {}

  # Lists component names contained in this store
  #
  # @param [Function] callback The callback to run
  #
  # @return [Array] The names of the components (in the callback)
  list: (callback)->
    callback? Object.keys(@db)

  # Retries a component from this store
  #
  # @param [String] name The name of the component
  # @param [Function] callback The callback to run
  #
  # @return [Object] The component (in the callback)
  get: (name, callback)->
    throw "Not enough arguments" if arguments.length is 0
    return callback(null) unless @db[name]
    callback? @db[name]

  # Stores a component from this store
  #
  # @param [String] name The name of the component
  # @param [Object] component The component
  # @param [Function] callback The callback to run
  set: (name, component, callback)->
    throw "Not enough arguments" if arguments.length < 2
    @db[name] = component
    callback?()

  # Removes a component from this store
  #
  # @param [String] name The name of the component
  # @param [Function] callback The callback to run
  remove: (name, callback)->
    throw "Not enough arguments" if arguments.length is 0
    delete @db[name]
    callback?()

module.exports = MemoryStore
