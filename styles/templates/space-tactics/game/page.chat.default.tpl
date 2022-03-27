{block name="title" prepend}{$LNG.lm_chat}{/block}
{block name="content"}

<div class="content_page" style="width: 95%;">
	<div class="title">
		{$LNG.lm_chat}
	</div>

	<div>
		<iframe src="./chat/index.php?action={$smarty.get.action|default:''|escape:'html'}" style="border: 0px;width:100%;height:800px;" ALLOWTRANSPARENCY="true"></iframe>
	</div>
</div>
{/block}