module.exports =
  fetchObjects: (client, params, callback) ->
    client.listObjects params, (error, data) ->
      if error
        console.log(error, error.stack)
      else
        objects = for item in data.Contents
          { Key: item.Key }

        callback(objects) if callback

  deleteObjects: (client, params, callback) ->
    if params.Delete.Objects.length is 0
      console.log("Bucket is already empty!")
    else
      client.deleteObjects params, (error, data) ->
        if error
          console.log(error, error.stack)
        else
          callback(data) if callback
