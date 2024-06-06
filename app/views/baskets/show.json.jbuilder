json.basket do
  json.books @books do |book|
    json.id book.id
    json.title book.title
    json.author book.author
    json.price book.price
    json.quantity @basket.data[book.id.to_s]['quantity']
  end
  json.total_price @basket.total_price
end