{*
* 2007-2012 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2012 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{if isset($products)}
	<!-- Products list -->
	<ul id="product_list" class="clearfix">
	{foreach from=$products item=product name=products}
		<li class="ajax_block_product {if $smarty.foreach.products.first}first_item{elseif $smarty.foreach.products.last}last_item{/if} {if $smarty.foreach.products.iteration%5 == 0}last_row_item{else}item{/if}">
		<a href="{$product.link}" title="{$product.name|escape:html:'UTF-8'}" class="product_image">
			{if $logged}
			<img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')}" height="{$homeSize.height}" width="{$homeSize.width}" alt="{$product.name|escape:html:'UTF-8'}" />
			{if isset($product.new) && $product.new == 1}<span class="new">{l s='New'}</span>{/if}
			{else}
			<img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default_watermark')}" height="{$homeSize.height}" width="{$homeSize.width}" alt="{$product.name|escape:html:'UTF-8'}" />
			{if isset($product.new) && $product.new == 1}<span class="new">{l s='New'}</span>{/if}
			{/if}
		</a>
		<p class="clear"></p>
		{if $product.show_price AND !isset($restricted_country_mode) AND !$PS_CATALOG_MODE}
		<h3 style="height:200px;"><a href="{$product.link}" title="{$product.name|escape:'htmlall':'UTF-8'}">{if isset($product.pack_quantity) && $product.pack_quantity}<span style="color:#3085FD">{$product.pack_quantity|intval|cat:' x '}</span>{/if}{$product.name|escape:'htmlall':'UTF-8'}</a></h3>
		{else}
		<h3 style="height:150px;"><a href="{$product.link}"  title="{$product.name|escape:'htmlall':'UTF-8'}">{if isset($product.pack_quantity) && $product.pack_quantity}<span style="color:#3085FD">{$product.pack_quantity|intval|cat:' x '}</span>{/if}{$product.name|escape:'htmlall':'UTF-8'}</a></h3>
		{/if}
		{if $product.show_price AND !isset($restricted_country_mode) AND !$PS_CATALOG_MODE}
			<div class="content_price">

					{*Discount patch *}
						{if $product.quantity_discounts}
							{$low = false}
							{foreach from= $product.quantity_discounts item='quantity_discount' name='quantity_discount'}
								{if $quantity_discount.reduction_type == 'amount'}
									{if !$priceDisplay}
										{$newPrice = $product.price-$quantity_discount.reduction}
									{else}
										{$newPrice = $product.price_tax_exc-$quantity_discount.reduction}
									{/if}
								{else}
									{if !$priceDisplay}
										{$disPrice = $product.price*$quantity_discount.reduction|floatval}
										{$newPrice = $product.price-round($disPrice,1)|floatval}
									{else}
										{$disPrice = $product.price_tax_exc*$quantity_discount.reduction|floatval}
										{$newPrice = $product.price_tax_exc - round($disPrice,1)|floatval}
									{/if}
								{/if}
								{$price=$newPrice|floatval}
								{if !$low}
									{$low = $price}
								{elseif $low > $price}
									{$low = $price}
								{/if}
							{/foreach}
							<span class="price" style="display: inline;">
								<span style="font-size:15px;">{convertPrice price=$low|floatval} - <br> {if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}</span>
							</span><br>
						{else}
							<span class="price" style="display: inline;">{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}</span><br><br />
						{/if}
					{*Discount patch *}
			{/if}
			{$stock = false}
			{foreach from=$product.features item=feature}
			{if isset($feature.value) && $feature.name=="Lager"}
				{if ($feature.value == "Slut i lager" || $feature.value == "Out of stock")}
					{$stock = $feature.value}
				{/if}
			{else}
				{if isset($feature.value) && $feature.name=="Leveranstid"}
					{$deliver = $feature.value}
				{/if}
			{/if}
			{/foreach}

					{if isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}
						{if isset($product.pack_quantity)}
							<span class="availability">&nbsp;</span>
						{elseif ($product.allow_oosp || $product.quantity > 0)}
							{if $stock && ($stock == "Slut i lager" || $stock == "Out of stock")}
								<span class="availability">&nbsp;</span>
							{else}
								<span class="availability">{l s='Available'}</span>
							{/if}
						{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}
							<span class="availability">{l s='Product available with different options'}</span>
						{else}
							<span class="availability">{l s='Out of stock'}</span>
						{/if}

					{/if}

			{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}<span class="on_sale">{l s='On sale!'}</span>
					{elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}<span class="discount">{l s='Reduced price!'}</span>
					{else}
					<span style="height:16px; margin: 5px 0; display: block"></span>
			{/if}

			{if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.minimal_quantity <= 1 && $product.customizable != 2 && !$PS_CATALOG_MODE}
			{if isset($product.pack_quantity)}
				<span style="width:110px;display:block;">&nbsp;</span>
			{elseif $stock && ($stock == "Slut i lager" || $stock == "Out of stock")}
				{if ($product.allow_oosp || $product.quantity > 0)}
					{if isset($static_token)}
						<a class="button ajax_add_to_cart_button exclusive_preorder gradient" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&id_product={$product.id_product|intval}&token={$static_token}", true)}" title="{l s='Pre-order'}">{l s='Pre-order'}</a>
					{else}
						<a class="button ajax_add_to_cart_button exclusive_preorder gradient" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&id_product={$product.id_product|intval}", true)}" title="{l s='Pre-order'}">{l s='Pre-order'}</a>
					{/if}
				{else}
					<span class="exclusive_preorder gradient">{l s='Pre-order'}</span><br />
				{/if}
			{else}
				{if ($product.allow_oosp || $product.quantity > 0)}
					{if isset($static_token)}
						{if $product.pre_order || ($product.quantity <= 0 && Configuration::get('PS_AUTO_PREORDER_NO_STOCK'))}
							<a class="button ajax_add_to_cart_button exclusive_preorder gradient" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&id_product={$product.id_product|intval}&token={$static_token}", true)}" title="{l s='Pre-order'}">{l s='Pre-order'}</a>	
						{else}
						<a class="button ajax_add_to_cart_button exclusive gradient" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&id_product={$product.id_product|intval}&token={$static_token}", true)}" title="{l s='Add to cart'}">{l s='Add to cart'}</a>
						{/if}
					{else}
						{if $product.pre_order || ($product.quantity <= 0 && Configuration::get('PS_AUTO_PREORDER_NO_STOCK'))}
							<a class="button ajax_add_to_cart_button exclusive_preorder gradient" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&id_product={$product.id_product|intval}", true)}" title="{l s='Pre-order'}">{l s='Pre-order'}</a>	
						{else}
						<a class="button ajax_add_to_cart_button exclusive gradient" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&id_product={$product.id_product|intval}", true)}" title="{l s='Add to cart'}">{l s='Add to cart'}</a>
						{/if}
					{/if}
				{else}
					{if $product.pre_order || ($product.quantity <= 0 && Configuration::get('PS_AUTO_PREORDER_NO_STOCK'))}
						<span class="exclusive">{l s='Pre-order'}</span><br />
					{else}
					<span class="exclusive">{l s='Add to cart'}</span><br />
					{/if}
				{/if}
			{/if}
			</div>
			{/if}
		</li>
	{/foreach}
	</ul>
	<!-- /Products list -->
{/if}
