{$short_pagination=ConfigHelper::checkConfig('phpui.short_pagescroller')}
<span class="bold">
{trans("Page:")}
{if $pagination->getPage() > 1}
    <a href="?m={$layout.module}&page={math equation="x - 1" x=$pagination->getPage()}">
{/if}
    {'&laquo;'|str_repeat:3}
{if $pagination->getPage() > 1}
    </a>
{/if}
{section name=pagination loop=$pagination->getPages()+1 step=1 start=1}
    {if $pagination->getPage() == $smarty.section.pagination.index}
        [{$smarty.section.pagination.index}]
    {else}
        {if !$short_pagination || ($short_pagination && ($smarty.section.pagination.index > $pagination->getPage() - 3 &&
            $smarty.section.pagination.index < $pagination->getPage() + 3) || $smarty.section.pagination.index < 3
            || $smarty.section.pagination.index > $pagination->getPages() - 3)}
        <a href="?m={$layout.module}&page={$smarty.section.pagination.index}">{$smarty.section.pagination.index}</a>
        {/if}
        {if $short_pagination && 
            (($smarty.section.pagination.index == $pagination->getPage() - 3 && $pagination->getPage() - 5 > 0)
            || ($smarty.section.pagination.index == $pagination->getPage() + 3 && $pagination->getPage() + 5 < $pagination->getPages()))}
        ...
        {/if}
    {/if}
{/section}
{if $pagination->getPage() <= $pagination->getPages()}
    <a href="?m={$layout.module}&page={math equation="x + 1" x=$pagination->getPage()}">
{/if}
    {'&raquo;'|str_repeat:3}
{if $pagination->getPage() <= $pagination->getPages()}
    </a>
{/if}
</span>
    ({t a=$pagination->getFirstOnPage() b=$pagination->getLastOnPage() c=$pagination->getTotal()}records $a - $b of $c{/t})
{if $pagination->getPages() > 9}
    {counter name=scroller print=false assign=scrollerno}
    <script type="text/javascript">
    <!--
        function pagechange{$scrollerno}() {
            var elem = document.getElementById('page{$scrollerno}');
            var pageelem = document.getElementById('page');
            if (pageelem !== null) {
                pageelem.value = elem.value;
                elem.form.submit();
            }
        }
    //-->
    </script>
    {t a="<input class=\"scroller\" type=\"text\" id=\"page`$scrollerno`\" value=\"\" size=\"3\">"}Go to $a page{/t}
    <a href="javascript: void(0);" onclick="javascript: pagechange{$scrollerno}();">&raquo;&raquo;&raquo;</a>
    </form>
{/if}