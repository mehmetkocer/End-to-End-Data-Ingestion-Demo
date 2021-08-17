import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._
import org.apache.spark.sql.SaveMode

object Json_converter {

  def main(args: Array[String]) {

    val spark = SparkSession
      .builder
      .appName("WordCount")
      .master("local[*]")
      .getOrCreate()

    val df = sqlContext.read.json("s3://intern-mehmetkocer/read/random_bank.json")
    df.write.parquet("s3://intern-mehmetkocer/read/")
  }
  
}
