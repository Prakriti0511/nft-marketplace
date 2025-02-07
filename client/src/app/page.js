"use client";
import Image from "next/image";
import Header from "./components/header/Header";
import styles from "./page.module.css";
import Footer from "./components/footer/Footer";
import Link from "next/link";

export default function HomePage() {
  return (
    <div className={styles.container}>
      <Header />
      <div className={styles.hero}>
        <div>
          <div className={styles.heading}>
            <h1>Where Art Meets Innovation, Step into NFTstore!</h1>
          </div>
          <p className={styles.description}>
            Enter the nexus of creativity and innovation at NFTstore. Uncover a
            realm of digital marvels, and together, let&apos;s redefine the future
            of collectibles.
          </p>
          <div className={styles.btns}>
            <Link
              href="/marketplace"
              className={`${styles.btn} ${styles.buyBtn}`}
            >
              Buy Now!
            </Link>
            <Link href="/sellNFT" className={styles.btn}>
              List Now!
            </Link>
          </div>
        </div>
        <Image
          src="/Designer.jpeg"
          alt="NFTs"
          width={400}
          height={400}
          priority
        />
      </div>
      <Footer />
    </div>
  );
}
