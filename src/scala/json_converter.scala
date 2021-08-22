import org.apache.spark.sql.SparkSession

object Json_converter {

  def main(args: Array[String]) {

    val spark = SparkSession
      .builder
      .appName("Json_converter")
      .master("local[*]")
      .getOrCreate()

    val df = spark.read.json("s3://intern-mehmetkocer/read/random_bank.json")
    df.write.parquet("s3://intern-mehmetkocer/write-bank-data/")
  }
  
}
