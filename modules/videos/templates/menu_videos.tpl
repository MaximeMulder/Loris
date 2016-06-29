<!-- Nav tabs -->
<ul class="nav nav-tabs nav-tabs-loris" role="tablist">
  <li role="presentation" class="active">
    <a href="#browse" aria-controls="browse" role="tab" data-toggle="tab">Browse</a>
  </li>
  <li role="presentation">
    <a href="#upload" aria-controls="upload" role="tab" data-toggle="tab">
      Upload
    </a>
  </li>
  {if $smarty.get.identifier}
    <li role="presentation">
      <a href="#edit" aria-controls="edit" role="tab" data-toggle="tab">
        Edit Video
      </a>
    </li>
  {/if}
</ul>

<!-- Tab panes -->
<div class="tab-content">

  <!-- Browse Videos -->
  <div role="tabpanel" class="tab-pane active" id="browse">
    {include file='../part/selection_filter.tpl'}
    <div id="datatable"></div>
  </div>

  <!-- Upload Videos -->
  <div role="tabpanel" class="tab-pane" id="upload">
      {include file='../part/video_upload.tpl'}
  </div>
</div>

<script>
  var table = RDynamicDataTable({
    "DataURL" : "{$baseurl}/videos/?format=json",
    "getFormattedCell" : formatColumn,
    "freezeColumn" : "File Name"
  });
  React.render(table, document.getElementById("datatable"));


  // Adds tab href to url + opens tab based on hash on page load
  // See: http://bit.ly/292MDI8
  $(function(){
    var hash = window.location.hash;
    hash && $('ul.nav a[href="' + hash + '"]').tab('show');

    $('.nav-tabs a').click(function (e) {
      $(this).tab('show');
      var scrollmem = $('body').scrollTop() || $('html').scrollTop();
      window.location.hash = this.hash;
      $('html,body').scrollTop(scrollmem);
    });
  });


</script>