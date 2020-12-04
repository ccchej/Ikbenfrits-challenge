module PastriesHelper
    def compute(packs, order)
        my_order = {}
        combinations = []
        packs.each do |pack|
            name = pack.pastry.name
            code = pack.code

            pcs = order/pack.qty.to_i
            total_qty = pcs*pack.qty

            if total_qty == order
                combinations.push({
                    name: name,
                    code: code,
                    packs: [
                        {
                            pcs: pcs,
                            price: pack.price,
                            qty: pack.qty
                        }
                    ],
                    total_cost: (pcs.to_f*pack.price.to_f).round(2)
                });
            end

            packs.each do |pack2|
                left = order - total_qty
                next if pack2.id == pack.id || left == 0

                if left == pack2.qty
                    combinations.push({
                        name: name,
                        code: code,
                        packs: [
                            {
                                pcs: pcs,
                                price: pack.price,
                                qty: pack.qty
                            },
                            {
                                pcs: 1,
                                price: pack2.price,
                                qty: pack2.qty
                            }
                        ],
                        total_cost: ((pcs.to_f*pack.price.to_f) + pack2.price.to_f).round(2)
                    });
                    next
                else
                    combined_qty = pack.qty+pack2.qty
                    if order == combined_qty
                        combinations.push({
                            name: name,
                            code: code,
                            packs: [
                                {
                                    pcs: 1,
                                    price: pack.price,
                                    qty: pack.qty
                                },
                                {
                                    pcs: 1,
                                    price: pack2.price,
                                    qty: pack2.qty
                                }
                            ],
                            total_cost: (pack.price.to_f + pack2.price.to_f).round(2)
                        });
                    else
                        pcs = 2
                        total_qty = pcs*pack.qty
                        combinations.push({
                            name: name,
                            code: code,
                            packs: [
                                {
                                    pcs: 1,
                                    price: pack.price,
                                    qty: pack.qty
                                },
                                {
                                    pcs: 1,
                                    price: pack2.price,
                                    qty: pack2.qty
                                }
                            ],
                            total_cost: (pack.price.to_f + pack2.price.to_f).round(2)
                        });
                    end
                end
            end

            break if !my_order.empty?
        end
        return combinations
    end
end