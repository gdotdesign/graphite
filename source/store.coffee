Utils = require './utils.coffee'

# Abstract base class for storing and retrieving components
#
# Every class that extends this class needs to have the follwing
#
# * list - Must return the names of the components
# * get - Must return a deserialzied component
# * set - Must save a comopnent
# * remove - Must remove a component
#
class Store
  # Placeholder for the list method
  list: -> console.warn Object.getPrototypeOf(@).constructor.name+'::list not implemented!'

  # Placeholder for the get method
  get: -> console.warn Object.getPrototypeOf(@).constructor.name+'::get not implemented!'

  # Placeholder for the set method
  set: -> console.warn Object.getPrototypeOf(@).constructor.name+'::set not implemented!'

  # Placeholder for the remove methods
  remove: -> console.warn Object.getPrototypeOf(@).constructor.name+'::remove not implemented!'

  # Deserialize component
  #
  # @param [Object] component The component to be deserialized
  #
  # @return [Object] The deserialized component
  deserialize: (component)->
    # Deserialize properties
    if component.properties
      for key,value of component.properties
        component.properties[key] = Function('value','create',value)

    # Deserialize events
    if component.events
      for key,value of component.events
        component.events[key] = Function('e','create',value)

    component

  # Serialize component
  #
  # @param [Object] component The component to be serializde
  #
  # @return [Object] The serialized component
  serialize: (component)->
    newComponent = {}

    # Copy 'static' properties
    newComponent.css = component.css.toString() if component.css
    newComponent.components = component.components if component.components

    # Serialize properties
    if component.properties
      newComponent.properties = {}
      for key, value of component.properties
        newComponent.properties[key] = if value instanceof Function then Utils.getBody value else value

    # Serialize Events
    if component.events
      newComponent.events = {}
      for key, value of component.events
        newComponent.events[key] = if value instanceof Function then Utils.getBody value else value

    newComponent

module.exports = Store
