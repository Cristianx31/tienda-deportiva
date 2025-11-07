// Simple cart using sessionStorage
(function(global){
  const KEY = 'cartItems';

  function getCart(){
    try{
      const raw = sessionStorage.getItem(KEY);
      return raw ? JSON.parse(raw) : [];
    }catch(e){
      return [];
    }
  }
  function saveCart(items){
    sessionStorage.setItem(KEY, JSON.stringify(items));
  }
  function addItem(item){
    const items = getCart();
    const idx = items.findIndex(i => String(i.id) === String(item.id));
    if(idx >= 0){
      items[idx].qty = (items[idx].qty || 1) + (item.qty || 1);
    } else {
      items.push({ id: String(item.id), name: item.name, price: Number(item.price)||0, image: item.image || '', qty: item.qty || 1 });
    }
    saveCart(items);
    return items;
  }
  function updateQty(id, qty){
    const items = getCart();
    const idx = items.findIndex(i => String(i.id) === String(id));
    if(idx >= 0){
      items[idx].qty = Math.max(1, Number(qty)||1);
      saveCart(items);
    }
    return items;
  }
  function removeItem(id){
    let items = getCart();
    items = items.filter(i => String(i.id) !== String(id));
    saveCart(items);
    return items;
  }
  function clear(){
    sessionStorage.removeItem(KEY);
  }
  function total(){
    return getCart().reduce((sum,i)=> sum + (i.price * (i.qty||1)), 0);
  }
  function formatCurrency(n){
    return (Number(n)||0).toFixed(2);
  }

  global.Cart = { getCart, saveCart, addItem, updateQty, removeItem, clear, total, formatCurrency };
})(window);
