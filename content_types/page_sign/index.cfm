<cfoutput>
	<div id="generatedSource" style="width:50%;margin:auto;">
	#Mura.dspObjects(1)#
	</div>
	<br/><br/>
	<div>
	<h2>Generated Source</h2>
	<textarea id="generatedSourceView" style="width:100%;height:200px"></textarea>
	</div>
</div>
	
	<script>
		var customerOptions={};
		Mura(function(){
			/*
			var state=Mura.getEntity('customizeTemplate')
				.load(orderid='')
				.then(function(t){
					t.set({
						...
					})
				});
			*/

			var modal=Mura('##customerModal');
			var modalBody=Mura('##customerModal .modal-body');
			var sourceObj;
			//This event doesn't seem to be heard with Mura.js
			$('##customerModal').on('show.bs.modal', function (e) {
				var source = event.target || event.srcElement;
				sourceObj=Mura(source).closest('div.mura-object');
		
				modalBody.html('').appendDisplayObject(
					Mura.extend({},
						sourceObj.data(),
						{object:sourceObj.data('object') + '_edit'}
					)
				)
			});

			Mura('##customerModal .modal-footer .btn-primary').on('click', function (e) {
				var customOptions={};
				modalBody.find('.objectParam').each(function(){
					
					var item=Mura(this);
					
					if(item.attr('id') && typeof CKEDITOR.instances[item.attr('id')] != 'undefined'){
						CKEDITOR.instances[item.attr('id')].updateElement();
						CKEDITOR.instances[item.attr('id')].destroy();
					}
					
					customOptions[item.attr('name')]=item.val();
				})

				sourceObj.data(customOptions);
				Mura.processAsyncObject(sourceObj.node).then(function(){
					//state.save();
				});
				$('##customerModal').modal('hide');
			
			});

			Mura(document).on('asyncObjectRendered',function(e){
				Mura('##generatedSourceView').val(Mura('##generatedSource .mura-region-local').html());
			});

		})
	</script>
	<div id="customerModal" class="modal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
		  <div class="modal-content">
			<div class="modal-header">
			  <h5 class="modal-title">Customize Content</h5>
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			  </button>
			</div>
			<div class="modal-body">
			  
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-primary">Save changes</button>
			  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		  </div>
		</div>
	  </div>
</cfoutput>
