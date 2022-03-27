{block name="title" prepend}{$LNG.fcm_info}{/block}
{block name="content"}

<div class="content_page">
	<div class="title">
		{$LNG.fcm_info}
	</div>

	<div>
		<table style="width: 100%;">
			<tr>
				<td><p>{$message}</p>{if !empty($redirectButtons)}<p>{foreach $redirectButtons as $button}<a href="{$button.url}"><button>{$button.label}</button></a>{/foreach}</p>{/if}</td>
			</tr>
		</table>
	</div>
</div>

{/block}