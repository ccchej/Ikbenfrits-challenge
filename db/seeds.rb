pastry = Pastry.create(name: 'Vegemite scroll')
Pack.create([
    {code: 'VS5', pastry_id: pastry.id, qty: 3,  price: '6.99'},
    {code: 'VS5', pastry_id: pastry.id, qty: 5,  price: '8.99'}
])

pastry = Pastry.create(name: 'Blueberry Muffin')
Pack.create([
    {code: 'MB11', pastry_id: pastry.id, qty: 2,  price: '9.95'},
    {code: 'MB11', pastry_id: pastry.id, qty: 5,  price: '19.95'},
    {code: 'MB11', pastry_id: pastry.id, qty: 8,  price: '24.95'}
])

pastry = Pastry.create(name: 'Croissant')
Pack.create([
    {code: 'CF', pastry_id: pastry.id, qty: 3,  price: '5.95'},
    {code: 'CF', pastry_id: pastry.id, qty: 5,  price: '9.95'},
    {code: 'CF', pastry_id: pastry.id, qty: 9,  price: '16.99'}
])