'use client'
import React, { useEffect, useState } from 'react';
import styles from './Row.module.scss'
import Counter from '../Counter/Counter.components';
import { Checkbox } from 'rsuite';

const Row = ({item, editItem, noEdit}:any) => {

    const [count, setCount] = useState(0);

    useEffect(() => {
        setCount(item.count)
    }, [item])

    function togleCount(value: number) {
        if(value <= 15){
            if(value > 0){
                editItem(item.id, "count-active", {active: true, count: value})
            }else{
                editItem(item.id, "count-active", {active: false, count: value})
            }
            setCount(value)
        }
        
        // editItem(item.id, "count", value)
    }

    return (
        <>
            {noEdit? 
            <div className={styles.row}>
                <div className={styles.checkbox}>{item.name}</div>
                {noEdit? "" : ""}
                <div className={styles.price} >{item.price} ₽</div>
                <b>{count}</b>
            </div>
            :
            <div className={styles.row}>
                <Checkbox onChange={(value: any, checked: any) => editItem(item.id, "active", checked)} checked={item.active} className={styles.checkbox}>
                    <div className={styles.tableName}>{item.name}</div>
                </Checkbox>
                {noEdit? "" : ""}
                <div className={styles.price} >{item.price} ₽</div>
                <Counter count={count} setCount={togleCount}/>
            </div>
            }
        </>
    );
};

export default Row;