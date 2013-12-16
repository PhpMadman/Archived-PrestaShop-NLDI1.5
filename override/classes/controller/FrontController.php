<?php

class FrontController extends FrontControllerCore
{
	public function productSort()
	{
		// $this->orderBy = Tools::getProductsOrder('by', Tools::getValue('orderby'));
		// $this->orderWay = Tools::getProductsOrder('way', Tools::getValue('orderway'));
		// 'orderbydefault' => Tools::getProductsOrder('by'),
		// 'orderwayposition' => Tools::getProductsOrder('way'), // Deprecated: orderwayposition
		// 'orderwaydefault' => Tools::getProductsOrder('way'),

		$stock_management = Configuration::get('PS_STOCK_MANAGEMENT') ? true : false; // no display quantity order if stock management disabled
		$order_by_values = array(0 => 'name', 1 => 'price', 2 => 'date_add', 3 => 'date_upd', 4 => 'position', 5 => 'manufacturer_name',7 =>'reference');
		if($stock_management) {
			$order_by_values[6] = "quantity";
		}
		$order_way_values = array(0 => 'asc', 1 => 'desc');
		$this->orderBy = Tools::strtolower(Tools::getValue('orderby', $order_by_values[(int)Configuration::get('PS_PRODUCTS_ORDER_BY')]));
		$this->orderWay = Tools::strtolower(Tools::getValue('orderway', $order_way_values[(int)Configuration::get('PS_PRODUCTS_ORDER_WAY')]));
		if (!in_array($this->orderBy, $order_by_values))
			$this->orderBy = $order_by_values[0];
		if (!in_array($this->orderWay, $order_way_values))
			$this->orderWay = $order_way_values[0];

		$this->context->smarty->assign(array(
			'orderby' => $this->orderBy,
			'orderway' => $this->orderWay,
			'orderbydefault' => $order_by_values[(int)Configuration::get('PS_PRODUCTS_ORDER_BY')],
			'orderwayposition' => $order_way_values[(int)Configuration::get('PS_PRODUCTS_ORDER_WAY')], // Deprecated: orderwayposition
			'orderwaydefault' => $order_way_values[(int)Configuration::get('PS_PRODUCTS_ORDER_WAY')],
			'stock_management' => (int)$stock_management
			)
			);
	}
}

