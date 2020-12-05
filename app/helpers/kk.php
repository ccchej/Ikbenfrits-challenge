<?php
$lowest_quantity_product = [];
$lowest_value_product = [];
foreach ($data[$item['name']] as $key => $product) {
    if (count($lowest_quantity_product) < 1) {
        $lowest_quantity_product = [
            'name'      => $key,
            'quantity'  => $product['quantity'],
            'value'     => $product['value']
        ];
    } else {
        if ($lowest_quantity_product['quantity'] > $product['quantity']) {
            $lowest_quantity_product = [
                'name'      => $key,
                'quantity'  => $product['quantity'],
                'value'     => $product['value']
            ];
        }
    }

    if (count($lowest_value_product) < 1) {
        $lowest_value_product = [
            'name'      => $key,
            'quantity'  => $product['quantity'],
            'value'     => $product['value']
        ];
    } else {
        $lowest_price = null;
        if ($lowest_price === null) {
            $lowest_price = $product['value'] / $product['quantity'];

            $lowest_value_product = [
                'name'      => $key,
                'quantity'  => $product['quantity'],
                'value'     => $product['value']
            ];
        } else {
            if ($lowest_price > ($product['value'] / $product['quantity'])) {
                $lowest_price = $product['value'] / $product['quantity'];

                $lowest_value_product = [
                    'name'      => $key,
                    'quantity'  => $product['quantity'],
                    'value'     => $product['value']
                ];
            }
        }
    }

    $orders[$item['name']] = [
        'order'     => $item['quantity'],
        'value'     => $lowest_quantity_product['value'] * 3,
        'result'    => [
            $lowest_quantity_product['name']    => 3
        ]
    ];

    $actual_quantity = $lowest_quantity_product['quantity'] * 3;
    if ($actual_quantity < $item['quantity']) {
        while ($actual_quantity < $item['quantity']) {
            if (array_key_exists($lowest_value_product['name'], $orders[$item['name']]['result'])) {
                $orders[$item['name']]['result'][$lowest_value_product['name']] += 1;
                $orders[$item['name']]['value'] += $lowest_value_product['value'];
                $actual_quantity += $lowest_value_product['quantity'];
            } else {
                $orders[$item['name']]['result'][$lowest_value_product['name']] = 1;
                $orders[$item['name']]['value'] += $lowest_value_product['value'];
                $actual_quantity += $lowest_value_product['quantity'];
            }
        }
    }
}
