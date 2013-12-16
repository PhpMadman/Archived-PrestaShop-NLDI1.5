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

<div id="contact_block" class="block">
	<h4 class="title_block">{l s='Contact us' mod='blockcontact'}</h4>
	<div class="block_content clearfix">
			<p>Kontakta vår kundtjänst</p>
			{if $telnumber != ''}<p class="tel"><span class="label">{l s='Phone:' mod='blockcontact'}</span>{$telnumber|escape:'htmlall':'UTF-8'}<span style="font-size:12px;"><br>Öppetider: 10-18</span></p>{/if}
<!-- 			{if $email != ''}<a href="mailto:{$email|escape:'htmlall':'UTF-8'}">Kontakt oss direkt via hemsidan</a>{/if} -->
			{if $email != ''}<a href="skype:{$email|escape:'htmlall':'UTF-8'}?chat" style="font-size:9px; display:block; height:10px;margin-bottom: 2px;" >Skype Anton - NL Distribution</a>{/if}
			<a href="/kontakta-oss" style="font-size:9px; display:block; height:10px;margin-bottom: 2px;" >{l s='Contact our hotline' mod='blockcontact'}</a>
	</div>
</div>
