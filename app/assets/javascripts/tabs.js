$(function()  {
  let tabs = $(".menu-item");
  function tabSwitch() {
    $('.active').removeClass("active");
    $(this).addClass("active");
    const index = tabs.index(this);
    $(".content").removeClass("show").eq(index).addClass("show");
  }
  tabs.click(tabSwitch);    
});