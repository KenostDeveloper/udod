'use client'
import Image from "next/image";
import styles from "./page.module.css";
import { Checkbox, Input, MaskedInput } from "rsuite";
import { FlexboxGrid, SelectPicker, Toggle } from 'rsuite';
import Counter from "./components/Counter/Counter.components";
import Row from "./components/row/Row.components";
import { use, useEffect, useState } from "react";
import axios from "axios";
import toast from "react-hot-toast";

export default function Home() {
  const [food, setFood] = useState<any>([]);

  const [selectFood, setSelectFood] = useState<any>([])
 
  const [promo, setPromo] = useState<any>([]);
  const [procent, setProcent] = useState(0);

  const [price, setPrice] = useState(0);

  const [order, setOrder] = useState<any>([]);

  const [page, setPage] = useState(0);
  const [user, setUser] = useState({
    name: "",
    address: "",
    tel: ""
  })

  useEffect(() => {
    axios
      .get("/api/food").then((res) => res.data)
      .then((data) => {
        setFood(data?.food);                
      });

    axios
      .get("/api/promo").then((res) => res.data)
      .then((data) => {
        setPromo(data?.promo);                
      });
      
  }, [])

  function editItem(id: string, property: any, value: any) {
    const nextShapes = food.map((characteristic: any) => {
        if (characteristic.id != id) {
          return characteristic;
        } else {
        // Return a new circle 50px below
          switch(property){
            case "active":
                if(value == false){
                  return {
                    ...characteristic,
                    active: value,
                    count: 0
                  };
                }else{
                  return {
                    ...characteristic,
                    active: value,
                    count: 1
                  };
                }
            case "count":
              return {
                ...characteristic,
                count: value,
              };
            case "count-active":
              return {
                ...characteristic,
                count: value.count,
                active: value.active,
              };
          }
        } 
    });
    setFood(nextShapes);
  }

  useEffect(() => {
    let tempCost = 0;
    for(let i = 0; i < food.length; i++){
      if(food[i].active){
        tempCost += food[i].price * food[i].count;
      }
    }

    setPrice(tempCost)

  }, [food])

  function editPage(value: any) {
    if(value == 1){
      let isNullBusket = true;
      for(let i = 0; i < food.length; i++){
        if(food[i].active){
          isNullBusket = false;
        }
      }

      for(let i = 0; i < promo.length; i++){
        if(price > promo[i].main_total_price && procent < promo[i].proccent){
          setProcent(promo[i].proccent)
        }
      }

  
      if(isNullBusket){
        toast.error("Пожалуйста, выберите хотя бы 1 товар!");
      }else{
        setPage(1)
      }
    }else if(value == 2){
      if(!user.name || !user.address || !user.tel){
        toast.error("Пожалуйста, заполните все поля!");
        return;
      }
      
      if(user.address.length < 10){
        toast.error("Пожалуйста, укажите корректный адрес!");
        return;
      }


      axios
      .post("/api/order", {food, user}).then((res) => res.data)
      .then((data) => {
        if(data.success){
          toast.success(data.message);
          setPage(2)

          setOrder(data.order)
        }else{
          toast.error(data.message);
        }
      });
    }
  }

  useEffect(() => {
    console.log(food)
  }, [food])

  function restart() {
    axios
      .get("/api/food").then((res) => res.data)
      .then((data) => {
        setFood(data?.food);                
      });

    setSelectFood([])
    setProcent(0);
    setPrice(0);
    setOrder([]);

    setUser({
      name: "",
      address: "",
      tel: ""
    })

    setPage(0);
  }

  function saveTXT(){

  }

  return (
    <>
        {page == 0?
          <main className={styles.main}>
            <div className={styles.left}>
              <div className={styles.logo}>
                <img src="/logo.svg" alt="" />
                {/* <p>Выберите содержимое заказа</p> */}
              </div>
              <div className={styles.sale}>
                <div className={styles.saleText}>
                  <b>Ваши скидки при заказе:</b>
                  {promo.map((item: any, index: any) => <p key={item.id} style={index == 0? {marginTop: "10px"} : {}}>от {item.main_total_price} ₽ - {item.proccent}%</p>)}
                </div>
              </div>
            </div>
            <div className={styles.right}>
              <h2>Выберите содержимое заказа</h2>
              <div className={styles.table}>
                {food.map((item: any) => <Row editItem={editItem} item={item} key={item.id}/>)}
              </div>

              <div className={styles.buttonContainer}>
                <button className={styles.button} onClick={() => editPage(1)}>Заказать</button>
              </div>
            </div>
          </main>
      :
      page == 1?
      <main className={styles.main}>
        <div className={styles.left}>
          <div className={styles.infoUser}>
            <h2>Данные заказчика</h2>
            <label>Имя заказчика:</label>
            <Input value={user.name} onChange={(value) => setUser({...user, name: value})}/>
            <label>Адрес доставки:</label>
            <Input value={user.address} onChange={(value) => setUser({...user, address: value})} />
            <label>Телефон:</label>
            <MaskedInput value={user.tel} onChange={(value) => setUser({...user, tel: value})} mask={['7', ' ', /[123456789]/, /\d/, /\d/, ' ', /\d/, /\d/, /\d/, ' ', /\d/, /\d/, ' ', /\d/, /\d/]} placeholder="7 999 453 32 21" />
          </div>
        </div>
        <div className={styles.right}>
          <h2>Выберите содержимое заказа</h2>
          <div className={styles.table}>
            {food.map((item: any) => item.active? <Row noEdit={true} editItem={editItem} item={item} key={item.id}/>: null)}
          </div>

          <div className={styles.resultPrice}>
            <b>Сумма заказа: <p>{price}₽</p></b>
            <b>Скидка {procent}%: <p>{(price / 100 * procent).toFixed(2)}₽</p></b>
            <b>Итого: <p>{(price - (price / 100 * procent)).toFixed(2)}₽</p></b>
          </div>
        
          <div className={styles.buttonContainer}>
            <button className={styles.button} onClick={() => editPage(2)}>Оформить</button>
          </div>
        </div>
      </main>
      :
      <main className={styles.main}>
        <div className={styles.left}>
          <div className={styles.cheack}>
            <p className={styles.cheackName}>Заказ #{order.id} оформлен!</p>
            <div className={styles.cheackProduct}>
              {food.map((item: any) => item.active? <Row noEdit={true} editItem={editItem} item={item} key={item.id}/>: null)}
            </div>
            <div className={styles.resultPrice}>
              <b>Сумма заказа: <p>{price}₽</p></b>
              <b>Скидка {procent}%: <p>{(price / 100 * procent).toFixed(2)}₽</p></b>
              <b>Итого: <p>{(price - (price / 100 * procent)).toFixed(2)}₽</p></b>
              <a style={{marginTop: "10px"}} className={styles.button} href={`/order_${order.id}.txt`} download>Сохранить</a>
            </div>
          </div>
        </div>
        <div className={styles.right}>
          <h2>Спасибо за заказ!</h2>
          
          <img className={styles.logoMin} src="/logo.svg" alt="" />
        
          <div className={styles.buttonContainer}>
            <button className={styles.button} onClick={() => restart()}>Новый заказ</button>
          </div>
        </div>
      </main>
      }
    </>
  );
}
