{capture name=path}{$paysistem->name}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}

<h2>Ordersammanfattning:</h2>

{assign var='current_step' value='payment'}
{include file="$tpl_dir./order-steps.tpl"}

{if isset($nbProducts) && $nbProducts <= 0}
	<p class="warning">Din varukorg är tom.</p>
{else}

<h3>{$paysistem->name}</h3>
<form action="{$link->getModuleLink('universalpay', 'validation', [], true)}" method="post">
	{$paysistem->description}
	<p>
		<b>Vänligen bekräfta din beställning genom att klicka på "Jag bekräftar min beställning"</b>
	</p>
	<p class="cart_navigation">
		<input type="hidden" name="id_universalpay_system" value="{$paysistem->id}" />
		<input type="submit" name="submit" value="Jag bekräftar min beställning" class="exclusive_large" />
		<a href="{$link->getPageLink('order', true, NULL, "step=3")}" class="button_large">Andra betalningsmetoder</a>
	</p>
</form>
{/if}
