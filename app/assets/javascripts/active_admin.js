//= require active_admin/base

$(document).ready(function(){
	$('.col.col-category_1 select').change(function(){
		var category_1_val = $(this).val();
		if (category_1_val){
			window.location = "/admin?category1="+category_1_val;
		}
		else{
			window.location = "/admin";
		}
	})

	$('.col.col-category_2 select').change(function(){
		var category_1_val = $('.col.col-category_1 select').val();
		var category_2_val = $(this).val();
		if (category_2_val){
			window.location = "/admin?category1="+category_1_val+"&category2="+category_2_val;
		}
		else{
			window.location = "/admin?category1="+category_1_val;
		}
	})

	$('.col.col-category_3 select').change(function(){
		var category_1_val = $('.col.col-category_1 select').val();
		var category_2_val = $('.col.col-category_2 select').val();
		var category_3_val = $(this).val();
		if (category_3_val){
			window.location = "/admin?category1="+category_1_val+"&category2="+category_2_val+"&category3="+category_3_val;
		}
		else{
			window.location = "/admin?category1="+category_1_val+"&category2="+category_2_val;
		}
	})

})